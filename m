Return-Path: <linux-kernel-owner+w=401wt.eu-S1751911AbXAREPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbXAREPI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 23:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbXAREPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 23:15:08 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:61133 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXAREPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 23:15:05 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aGkPK5MTprf/ZVmEMEFVX2/Q0+wazk7KPYREwKXZlyzvrZDjg55rctBfOY1uFWXL8UfmfyHfjkQkVTuQY5UDC3xHY7RK3ZPLkBe9OYKTTMmIyr2PtXfy6Rzjxnikvpar3us5owGcnmJRDZ1k/CneKvP6ajXGcFsn3J+7Gy9hNNs=
Message-ID: <292693080701172015n736a269fl6945ba4fe19d8174@mail.gmail.com>
Date: Thu, 18 Jan 2007 09:45:04 +0530
From: "Daniel Rodrick" <daniel.rodrick@gmail.com>
To: kernelnewbies <kernelnewbies@nl.linux.org>,
       "Linux Newbie" <linux-newbie@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: after effects of a kernel API change
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

Whenever there is a change in the kernel API (or a new API is
introduced), all of the drivers that use the older API need to be
changed (or recommended to be changed). I believe it is the
responsibility of the person changing the kernel API, to change all
the drivers that have found their way into the kernel code?

How does this happen? Because the person who brought the change in the
API might not know the internals of all the drivers?

Is there any way volunteers like me can help in this exercise?

Thanks,

Dan
