Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWBPLvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWBPLvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 06:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBPLvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 06:51:08 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:19411 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751366AbWBPLvH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 06:51:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uf9+grk+JwKodZSwy34tP81HDYHnq/W583z6yWPZtVzze91xDVqoanABtb327o8HSmeYlakhA8RnkdHr3ySNdh6SaAQTa3B0Fdst2AQ7/VBkp1e0IvlWo2Bw+d+RVskJD2zlKS4fT+4peHC+DfY2ISpACic+a6k0RiAs/eQDWRk=
Message-ID: <993d182d0602160351h454cf23dj9f5454c9eca98ef@mail.gmail.com>
Date: Thu, 16 Feb 2006 17:21:05 +0530
From: Conio sandiago <coniodiago@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: configure local printer
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All
i have a embedded linux successfully runing.
I want to add a printer in that.
Printer has usb interface.
The printer is succefully detected and a device node is created
in /dev/usb/lp0.

if i print a text file using following command

cat /temp.txt > /dev/usb/lp0
then the file is successfully printed.

Now i want to print a jpeg image
can anyone please let me know
how to do this

thanks
conio
