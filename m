Return-Path: <linux-kernel-owner+w=401wt.eu-S1751007AbWL2Kaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWL2Kaa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWL2Kaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:30:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:54644 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbWL2Ka3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:30:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EOP6+he0Fkc27n70QVhC3oyOLGnCZz7zyW93PB/VktU79rVGnlTZHwZsf6c7F7+mRG/UWjDUS9ODwWKjmewiC8/AiohN4alvY1rLTK6LSSzZKOcrK2mS3wpjkHmlAGIuH+XdTfMbQhDLx+NlZAgFHUoWCVmyDgA85OH3R2gHM14=
Message-ID: <b6a2187b0612290230g7e494670h6396e2f0a4ecea10@mail.gmail.com>
Date: Fri, 29 Dec 2006 18:30:27 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: any chance to bypass BIOS check for VT?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kvm: disabled by bios

I know this has been asked before and the answer was no. Does it still
stand or is there a way to bypass the bios? I'm using Lenovo X60s and
there's no option to enable VT in the BIOS setup.

/proc/cpuinfo shows "VMX".


Another question ... how to enable "mouse" in KVM?


Thanks,
Jeff.
