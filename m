Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266076AbUFVVND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUFVVND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUFVVMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:12:35 -0400
Received: from mail-gw4.njit.edu ([128.235.251.32]:3768 "EHLO
	mail-gw4.njit.edu") by vger.kernel.org with ESMTP id S265958AbUFVUs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:48:29 -0400
Date: Tue, 22 Jun 2004 16:48:27 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: linux-kernel@vger.kernel.org
Subject: sk_buff structure
Message-ID: <Pine.GSO.4.58.0406221647570.10319@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to modify the kernel networking code and have a question
regarding the sk_buff structure which is used to store the details of a
packet.
In this structure there are pointers called headroom, data, tailroom and
end. Does anyone know what these are used for. Or can anyone point me to a
good explanation for these fields.

I wanted to know how exactly they are populated ? Whether the headroom
contains the different headers ? What does the tailroom contain ?

Thanks,
Rahul.
