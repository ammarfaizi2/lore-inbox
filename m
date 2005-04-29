Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVD2P7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVD2P7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVD2P6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:58:04 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:2681 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262309AbVD2P5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:57:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=epuezRybMw+vsUmrRINixJ/8Dm/4VUb0ktGy6JAodrG9eSSCNutqXVvaTtcgUbW/Lj+lZzmFqG8qmJyzr5GmJp6DsQooSpDoFLvulg4OvlQ/2jPznpjIE8n+vqWuhqSnrE97nrkza82bSImvTuxt8bf8alO0LskbDZ3aMWhVmaQ=
Message-ID: <42725952.7060505@gmail.com>
Date: Fri, 29 Apr 2005 17:57:06 +0200
From: Eric BEGOT <eric.begot@gmail.com>
Reply-To: eric.begot@gmail.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Inotify application
Content-Type: multipart/mixed;
 boundary="------------080504010901010309000309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080504010901010309000309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

here is a little program which uses the inotify's functionnality. This 
soft lists a given directory in live. The informations are updated when 
an event occur. If no event occur, the process does nothing and sleeps !
The soft needs the libncurses (and inotify patch of course).
rml advised me to post this to the lkml so the others will be able to 
see how nice the inotify stuff is :)

ciao

--------------080504010901010309000309
Content-Type: application/x-bzip;
 name="inotify_app.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="inotify_app.tar.bz2"

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
1HTCB/4u5IpwoSEBkDk8
--------------080504010901010309000309--
