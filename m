Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbRE0BOo>; Sat, 26 May 2001 21:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbRE0BOe>; Sat, 26 May 2001 21:14:34 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.121.50]:8179 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262675AbRE0BOV>; Sat, 26 May 2001 21:14:21 -0400
Message-Id: <27200125529513.Amiga@SMTP.earthlink.net>
Reply-To: jpcpt@earthlink.net
From: jpcpt@earthlink.net (Joseph S Price)
Date: Sat, 27 May 2001 21:11:25
Subject: FWD: [RHSA-2000:108-02] Updated modutils fixing local root 
X-Form: TheSimpsons
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=====_0121112227==_"
To: jpcpt@earthlink.net
CC: =?ISO-8859-1?Q?=08I=F4=08@avocet.mail.pas.earthlink.net?=
Organization: None
X-Mailer: StarGate v2.5 [68K MUI] -- Amiga Mailer By Danny Y. Wong
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format.
If you can read this then your mail reader
does not understand MIME format.

--=====_0121112227==_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2000 12:31 -0500 you talked about...

>---------------------------------------------------------------------
>                   Red Hat, Inc. Security Advisory
>
>Synopsis:          Updated modutils fixing local root security bug
available
>Advisory ID:       RHSA-2000:108-02
>Issue date:        2000-11-16
>Updated on:        2000-11-16
>Product:           Red Hat Linux
>Keywords:          modutils root exploit security
>Cross references:  N/A
>---------------------------------------------------------------------
>
>1. Topic:
>
>A local root exploit in modutils has been fixed.
>
>2. Relevant releases/architectures:
>
>Red Hat Linux 6.2 - i386, alpha, sparc
>Red Hat Linux 6.2EE - i386, alpha, sparc
>Red Hat Linux 7.0 - i386
>Red Hat Linux 7.0J - i386
>
>3. Problem description:
>
>modutils, a package that helps the kernel automatically load kernel modules
>(device drivers etc.) when they're needed, could be abused to execute code
>as root.
>
>
>
>modutils versions between 2.3.0 and 2.3.20 are affected.
>
>4. Solution:
>
>For each RPM for your particular architecture, run:
>
>
>
>rpm -Fvh [filename]
>
>
>
>where filename is the name of the RPM.
>
>5. Bug IDs fixed (http://bugzilla.redhat.com/bugzilla for more
info):
 >
>20749 - local root exploit via modutils
>
>
>6. RPMs required:
>
>Red Hat Linux 6.2:
>
>alpha:
>ftp://updates.redhat.com/6.2/alpha/modutils-2.3.20-0.6.2.alpha.rpm
>
>sparc:
>ftp://updates.redhat.com/6.2/sparc/modutils-2.3.20-0.6.2.sparc.rpm
>
>i386:
>ftp://updates.redhat.com/6.2/i386/modutils-2.3.20-0.6.2.i386.rpm
>
>sources:
>ftp://updates.redhat.com/6.2/SRPMS/modutils-2.3.20-0.6.2.src.rpm
>
>Red Hat Linux 7.0:
>
>i386:
>ftp://updates.redhat.com/7.0/i386/modutils-2.3.20-1.i386.rpm
>
>sources:
>ftp://updates.redhat.com/7.0/SRPMS/modutils-2.3.20-1.src.rpm
>
>7. Verification:
>
>MD5 sum                           Package Name
>--------------------------------------------------------------------------
>0b4bb8f26ac126db756cfbc84543d7cf  6.2/SRPMS/modutils-2.3.20-0.6.2.src.rpm
>7540818796b9ab0961465f67118ffac9  6.2/alpha/modutils-2.3.20-0.6.2.alpha.rpm
>206cb6ccd33a0f16803695e0246abb35  6.2/i386/modutils-2.3.20-0.6.2.i386.rpm
>d8226ab998719f79f3df9d4e9a6bb88a  6.2/sparc/modutils-2.3.20-0.6.2.sparc.rpm
>1502c3cc848fec4ecdaf5903b9f2cbb4  7.0/SRPMS/modutils-2.3.20-1.src.rpm
>166b7512c784ffaa4233e8f71ef712cd  7.0/i386/modutils-2.3.20-1.i386.rpm
>
>These packages are GPG signed by Red Hat, Inc. for security.  Our key
>is available at:
>http://www.redhat.com/corp/contact.html
 >
>You can verify each package with the following command:
>    rpm --checksig  <filename>
>
>If you only wish to verify that each package has not been corrupted or
>tampered with, examine only the md5sum with the following command:
>    rpm --checksig --nogpg <filename>
>
>8. References:
>
>N/A
>
>
>Copyright(c) 2000 Red Hat, Inc.
>
>
>
>_______________________________________________
>Redhat-watch-list mailing list
>To unsubscribe, visit:
https://listman.redhat.com/mailman/listinfo/redhat-watch-list
>
>


Regards,


-- 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--=====_0121112227==_--
