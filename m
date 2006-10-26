Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWJZLIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWJZLIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWJZLIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:08:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:42522 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751758AbWJZLIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:08:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CrftaRmGitwdD0+MFFYHrDPUFsEGUu3P8ZfO4LwoULhd5TfKmGUKvdszzm3xk2c4loeb7Uzk9FB6LySFJe8MHveWgFmI+XmSXpb9cCa9GltCBLjgkGn/x65iz1TbO2kXtOn+5rxDvNo7HzIIvRcJlAF85eifGFeyxm3j0qGvhJ4=
Message-ID: <5d87a57d0610260408j641545c7oe9f9d74bdb19a321@mail.gmail.com>
Date: Thu, 26 Oct 2006 16:38:29 +0530
From: "robert george" <robezy.kernel@gmail.com>
Subject: compiling bcm4xx module
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
    i am having 2.6.16-13 kernel .This kernel lack support for broadcom
wireless card.But the latest kernel is having support for this card.

   I download the the kernel ,but i would like to compile this particular

driver only , not the entire kernel.
   Is it possible???

  I tried to execute the following command
  make -C /usr/src/linux-2.6.16-13 SUBDIRS=$PWD  modules

  but got following error  message ..

  ' No reason to target modules'

  How can i compile the driver separately???
