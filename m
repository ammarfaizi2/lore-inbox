Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757679AbWKXLLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679AbWKXLLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757682AbWKXLLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:11:12 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:22676 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1757678AbWKXLLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:11:11 -0500
Message-ID: <4566D349.8080004@scientia.net>
Date: Fri, 24 Nov 2006 12:11:05 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: unexplainable read errors, copy/diff-issue
References: <4553DD90.1090604@scientia.net> <20061110135649.16cccca0.vsu@altlinux.ru>
In-Reply-To: <20061110135649.16cccca0.vsu@altlinux.ru>
Content-Type: multipart/mixed;
 boundary="------------060003030808060109070007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060003030808060109070007
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi again,...
The issue still exists an until now I (or Tyan or Hitachi or Nvidia)
hasn't found any solution.

Could you please tell me if the sata_nv driver uses Native Command
Queueing (NCQ)?
This could perhaps help me to further trace the problem down, although
this is not very likely as the issue appeard on IDE disks, too, which
shouldn't use NCQ ;)

Thanks,
Chris.

--------------060003030808060109070007
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------060003030808060109070007--
