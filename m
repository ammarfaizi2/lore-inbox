Return-Path: <linux-kernel-owner+w=401wt.eu-S1030183AbXADTqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbXADTqn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbXADTqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:46:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:39757 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030183AbXADTqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:46:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RxGrNnjTQjugFNIBvo5pSi2awvA/EOE/M8xuVJ5GcGIRsI1knUIOSpBRSLqK44+gLQ6GSTFvnSBI0BweR6Ec7/Z/2WlD1FCFnpKPP5G9ArjvM3BZppbK1InUsTlKixUu8PkSN3gTGvW3k1824m6+woNYJcFJ/+XoMcCHGvK9QH0=
Message-ID: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
Date: Fri, 5 Jan 2007 01:16:37 +0530
From: Akula2 <akula2.shark@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Multi kernel tree support on the same distro?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am looking to use multiple kernel trees on the same distro. Example:-

2.6.19.1 for - software/tools development
2.4.34    for - embedded systems development.

I do know that 2.6 supports embedded in a big way....but still
requirement demands to work with such boards as an example:-

http://www.embeddedarm.com/linux/ARM.htm

My question is HOW-TO enable a distro with multi kernel trees?
Presently am using Fedora Core 5/6 for much of the development
activities (Cell BE SDK related at Labs).

Any hints/suggestions would be a great leap for me to do this on my own.

~Akula2
