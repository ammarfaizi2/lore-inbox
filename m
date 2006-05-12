Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWELGyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWELGyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWELGyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:54:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:55640 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751016AbWELGyV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:54:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Dw2cx6f3myCvI6PnAikrJ0nBXg50BDAX9EHpiq8DgvURxH379sKhiCzh9OSon79tJmd7m4ZM1qrfWWhtwXUfWSDOyl3QlwHk916cUeDVCeNYNT9CTqhAM1NSZ+F6wot9XAhAwwLIZc7NrrRehEUN+VNnreGr/iXrJJX2CzMZ5fc=
Message-ID: <ae649ba00605112354k5b91cb0cwb5e67723f6560720@mail.gmail.com>
Date: Fri, 12 May 2006 12:24:20 +0530
From: "Krishna Chaitanya" <lnxctnya@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux for Asymmetric Multi Processing Systems.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All!

I am working on a project where the hardware is Asymmetric Multi
Processing Systems(ASMP).

In my system I have one ARM9,  four ARM7s'.

1. Can I use one Linux Kernel for all the CPUs in an ASMP system. (or)
    Should I use One Linux Kernel for ARM9 and RTOSes for ARM7.
2. If my hardware would come up in future with another ARM7 does linux
scale for the new CPU.

Can anyone please direct me to the source/docs how to use Linux for
ASMP systems.

Thanks,
krs
