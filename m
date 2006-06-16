Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWFPL3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWFPL3D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWFPL3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:29:03 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:33446 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750735AbWFPL3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:29:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iaJVmFbhdlEGx8NjigvzR/0OBhu9trMR0NEXPidPgxA7geA/z5XSwOWpzv8bNj2TEBl9VJqdYsim7qrXHeygN/b6E/uiKPGOxZbn9SpvwBFu2ou9NFYkpt9t7qqhkW7MRMNDZeAh2I8GnXCldZrq9oz6Td+97EoGEVO7oLG8Rio=
Message-ID: <8bf247760606160428s4070f543t329eee7fb44921c7@mail.gmail.com>
Date: Fri, 16 Jun 2006 16:58:59 +0530
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: procfs and sysfs changes?
Cc: linux-arm-kernel@lists.arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  i am porting a driver from 2.4 to 2.6.

   I went thru the porting guide available in lwn.net. some parts of
the document is difficult to follow for begineers.


  am confused.

  Could any one let me know what changes i need to make in a 2.4 driver
  as far as /proc interface is concerned.

  Should i make any new additions to support sysfs?.  am cofused
regarding the need
  of sysfs when /proc is already there.


  Could anyone help me on this.

  pointers will be very helpful.


Regards,
sriram
