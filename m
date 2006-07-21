Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWGUFGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWGUFGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 01:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWGUFGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 01:06:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:45003 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030454AbWGUFGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 01:06:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qFHBP3sfilWWM8vNT7AZiTUYrGzfR74X/k702AeldKVoYaGw7phivbT+smllFKLZ7WN4VUlMFaYn4W2Jp8332QVjR4o+14gv++DtkRYajv9QDH2qhDiGvtxm4iWLqV00NViTP1w00EbmmjQz73bnPn/Z/GBbna5cC8Y5RHtq42I=
Message-ID: <3420082f0607202206j78569b3fm56d61138c65426bf@mail.gmail.com>
Date: Fri, 21 Jul 2006 10:06:53 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: why is intercepting system calls considerred bad?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

I recently met a kernel janitor, who told me that intercepting system
calls is undesirable, why?
