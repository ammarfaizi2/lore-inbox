Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274684AbRJ0Sqy>; Sat, 27 Oct 2001 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274749AbRJ0Sqp>; Sat, 27 Oct 2001 14:46:45 -0400
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:40296 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S274684AbRJ0Sqf>; Sat, 27 Oct 2001 14:46:35 -0400
Posted-Date: Sat, 27 Oct 2001 17:52:23 GMT
Date: Sat, 27 Oct 2001 18:52:23 +0100 (BST)
From: Riley Williams <root@MemAlpha.CX>
Reply-To: Riley H Williams <rhw@MemAlpha.CX>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.13 default config
Message-ID: <Pine.LNX.4.21.0110271847240.12381-200000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463746820-440807272-1004204939=:12381"
Content-ID: <Pine.LNX.4.21.0110271851040.17902@Consulate.UFP.CX>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463746820-440807272-1004204939=:12381
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0110271851041.17902@Consulate.UFP.CX>

Hi Alan, Linus.

The enclosed patch (against the raw 2.4.13 tree) adds a `make defconfig`
option that configures Linux with the default options obtained by simply
pressing ENTER to every prompt that comes up.

On my ix86 system and against this kernel, it produces a config that is
identical to that in arch/i386/defconfig but this is NOT true of some of
the other kernel releases.

Please apply.

Best wishes from Riley.

---1463746820-440807272-1004204939=:12381
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="defconfig.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0110271848590.12381@Consulate.UFP.CX>
Content-Description: make defconfig
Content-Disposition: ATTACHMENT; FILENAME="defconfig.diff"

LS0tIGxpbnV4LTIuNC4xMy9NYWtlZmlsZX4JV2VkIE9jdCAyNCAwNjoyMToy
MCAyMDAxDQorKysgbGludXgtMi40LjEzL01ha2VmaWxlCVNhdCBPY3QgMjcg
MTg6NDY6NDcgMjAwMQ0KQEAgLTI3NCw2ICsyNzQsMTAgQEANCiAJCW1rZGly
IGluY2x1ZGUvbGludXgvbW9kdWxlczsgXA0KIAlmaQ0KIA0KK2RlZmNvbmZp
ZzoNCisJcm0gLWYgLmNvbmZpZw0KKwl5ZXMgJycgfCBtYWtlIGNvbmZpZw0K
Kw0KIG9sZGNvbmZpZzogc3ltbGlua3MNCiAJJChDT05GSUdfU0hFTEwpIHNj
cmlwdHMvQ29uZmlndXJlIC1kIGFyY2gvJChBUkNIKS9jb25maWcuaW4NCiAN
Cg==
---1463746820-440807272-1004204939=:12381--
