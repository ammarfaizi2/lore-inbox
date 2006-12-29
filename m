Return-Path: <linux-kernel-owner+w=401wt.eu-S1754905AbWL2PO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbWL2PO3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbWL2PO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:14:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:4294 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905AbWL2PO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:14:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tsF0dQmfds1gtjo44ch6q31FprDnh0eT+5KoYpOtDv633hiAbJ8NbkQcUzdppHW+oMbhYuiuf3bmDegPkWeMokC16ya+tp6VdK4NDjRDvg7sn2tyrhZpQDZ4mbGC+ypdc+m8XB5uium4lcYfu+lQLcEwOiWbefrQk4O0DYd9ghA=
Message-ID: <b6a2187b0612290714g4ce65aa2n82752ae73e651a38@mail.gmail.com>
Date: Fri, 29 Dec 2006 23:14:27 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: KVM ... bypass BIOS check for VT?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending this under KVM as a subject and hope to get response.

kvm: disabled by bios

I know this has been asked before and the answer was no. Does it still
stand or is there a way to bypass the bios? I'm using Lenovo X60s and
there's no option to enable VT in the BIOS setup.

/proc/cpuinfo shows "VMX".


Another question ... how to enable "mouse" in KVM?


Thanks,
Jeff.
