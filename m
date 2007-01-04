Return-Path: <linux-kernel-owner+w=401wt.eu-S965126AbXADW1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbXADW1g (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbXADW1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:27:36 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:32809 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965126AbXADW1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:27:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JAaB8wHl26GYsBOZUMgJK73Tm8SZIv8hio4wFdINP2LD3SziJRoHg65CeOU93ImKwXkeweUiBSzgrMfCu9vaERABG64n7RBjmxF0H1QyGFQxEy4wdiBVzyTETT8ZTx/fuEBgwUbj+qeF3MI2lg3ynFnQ6TSwAa+utUT9neuyerQ=
Message-ID: <f36b08ee0701041427u7aee90b7j46b06c3b7dd252bd@mail.gmail.com>
Date: Fri, 5 Jan 2007 00:27:34 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: "Kernel Linux" <linux-kernel@vger.kernel.org>
Subject: how to get serial_no from usb HD disk (HDIO_GET_IDENTITY ioctl, hdparm -i)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I get serial_no from usb-attached HD drive ?

 The HDIO_GET_IDENTITY ioctl fails (like 'hdparm -i').
 Any advice on how to extract the drive serialNo from the usb disk ?
 Can I write kernel module to extract the SerialNo ?
 (I don't need whole 'struct hd_driveid', only the SerialNo).

 Thanks
 Yakov
