Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVGUWlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVGUWlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVGUWlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:41:35 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:21236 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261914AbVGUWjo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:39:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XzIiqae0Pe9ZnrTWRTInDdO7BoTFP1jBrfih/BDEjO3nKLbSwUmaFh0GphxREZvb0+biNKcRN4TNJ1UW+QBUo+Io6nhrm34l+lZGlL7fZJpyWWvp32fNt0Gn7UAAbr1DiIbuLtaP8+Cmw1cg0EdOOVy8TFihMIyuDNDGVQbIAHU=
Message-ID: <2de37a4405072115392cfd5470@mail.gmail.com>
Date: Fri, 22 Jul 2005 00:39:41 +0200
From: Michael Thonke <iogl64nx@gmail.com>
Reply-To: Michael Thonke <iogl64nx@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Support for Silicon Image 3132 SATA II Controller
Cc: jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got a new Silicon Image 3132 SATA II host-controller, this one is
designed along the SATA (II) specification - (Hot-Plug,NCQ,3GB/s
transfer). This controller is linked to the pci-express bus. I guess
it operate like the 3124 controller with some addition :-) On the
Silicon Image website I found some papers for this controller and his
architecture. It can be found here
http://www.siliconimage.com/products/product.aspx?id=32&ptid=1

I can provide a pci-ids for some specific boards if needed...I found
this controller on some new motherboards Gigabyte's 955X Royal, ABIT
AW8,ECS PF88 Extreme, TUL,Foxconn and maybe others coming.

Is it possible to implement this controller to libata: sata_sil
driver? I also would spend some time to test the driver.

Thanks for help and assistence

Greets
-- 
Mit freundlichen Grüßen
Michael Thonke

Best regards
Michael Thonke
