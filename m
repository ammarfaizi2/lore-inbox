Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSDNOqN>; Sun, 14 Apr 2002 10:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312344AbSDNOqM>; Sun, 14 Apr 2002 10:46:12 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:62621 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S312334AbSDNOqL>;
	Sun, 14 Apr 2002 10:46:11 -0400
Message-ID: <3CB99689.7090105@nokia.com>
Date: Sun, 14 Apr 2002 17:47:37 +0300
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020211
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [new release] Affix-0_99  --- Bluetooth Protocol Stack. OBEX and GUI available now.
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com> <3CA3A149.1080905@nokia.com> <3CAE2484.8090304@nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2002 14:46:08.0709 (UTC) FILETIME=[1CF5E750:01C1E3C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

Find new Affix release Affix-0_99 on http://affix.sourceforge.net

Profiles supported:
- Service Discovery.
- Serial Port.
- LAN Access.
- Dialup Networking.
- OBEX Object Push.
- OBEX File Transfer.
- PAN.

GUI environment A.F.E - Affix Frontend Environment available for use.
http://affix.sourceforge.net/afe
Link can be found on Affix WEB site in *Links* section.


CHANGES.

Version 0.99 [14.04.2002]
- [fix/changes] some SDP parts re-written.
- [changes] sockaddr_{hci,l2cap,rfcomm} repleaced by *sockaddr_affix*
	!NOTE: it requires to recompile and reinstall whole affix
- [new] *btctl* has now *prompt* (ftp) command - interactive shell &
	File Transfer Console (OBEX).
- [new] OBEX client now full featured (in ftp mode).
	commands: open, close, put, get, push, rm, cd, mkdir
- [new] Linux kernel 2.5.x supported (not well tested)
- [new] added new info to README (usage examples, commands explanation).


br, Dmitry



