Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWJCIOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWJCIOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWJCIOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:14:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:11501 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030258AbWJCIOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:14:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rRxrLVQMuRx83H8V8i3mgISzInAn5wpj/TrT7u6tRs9eNw/YQRGrwSUwvsQtnvZjN2P88Loj7RH78Ewca5mByYw4pakSbR4yCT8i2cdpk1Jk34cNRFI/hj2RODLQd6zX8FinewIyRqnoxS6kW1mjaG85OFjE6kdD8dEx6d5y79A=
Message-ID: <3420082f0610030114o4c6998en907bccce81d28c59@mail.gmail.com>
Date: Tue, 3 Oct 2006 13:14:52 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Fwd: Any way to find the network usage by a process?
In-Reply-To: <3420082f0610030114o5b44b8ak7797483e02002614@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3420082f0610030114o5b44b8ak7797483e02002614@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any method either kernel or user level which tells me which
process is generating how much traffic from a machine. For example if
some process is flooding the network, then I would like to know which
process (PID ideally), is generating the most traffic.

Some people told me to monitor ports and check through nmap which
process is using that port, but thats not a good approach as there is
nothing to restrict a process to use the same port for its lifetime,
it can close it and open another one etc..

I dont require it to do this remotely, it should be run on the same
machine as that originates the traffic
Any help will be highly appreciated

Regards
Irfan
