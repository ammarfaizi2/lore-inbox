Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSLCT6b>; Tue, 3 Dec 2002 14:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSLCT6b>; Tue, 3 Dec 2002 14:58:31 -0500
Received: from sammy.netpathway.com ([208.137.139.2]:24336 "EHLO
	sammy.netpathway.com") by vger.kernel.org with ESMTP
	id <S265567AbSLCT6a>; Tue, 3 Dec 2002 14:58:30 -0500
Message-ID: <3DED0EAE.7090705@netpathway.com>
Date: Tue, 03 Dec 2002 14:06:06 -0600
From: Gary White <gary@netpathway.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
References: <200211292324.gATNOQO26672@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 1.0.12.4 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are the below lines in the 2.4.20-rc1 patch a little premature?
I don't see any patch code for quotas in the reiserfs and I can't
get quotas to work for reiserfs. Am I missing something?


-  usage (also called disk quotas). Currently, it works only for the
-  ext2 file system. You need additional software in order to use quota
+  usage (also called disk quotas). Currently, it works for the
+  ext2, ext3, and reiserfs file system. You need additional software

-- 
Gary White                                  admin@netpathway.com
Network Administrator                           Internet Pathway
105 D East Church Street                     Voice: 601-776-3355
P. O. Box 777                                  Fax: 601-776-2314
Quitman, MS 39355            Registered Linux User Number 198875




________________________________________________________
This email has been scanned by Internet Pathway's Email
Gateway scanning system for potentially harmful content,
such as viruses or spam. Nothing out of the ordinary was
detected in this email. For more information, call
601-776-3355 or email emailscanner@netpathway.com
________________________________________________________
