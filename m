Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVCROI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVCROI7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 09:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVCROI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 09:08:59 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:32169 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261608AbVCROIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 09:08:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=b+mz8cigzARXXrELZ09h0DM2ZysT8h7n5f8cmOBMpiOJrKqQ5Pxt7C6AZefnoyTyhdrvrbQs6sfnOo2m+WSxzEtQxU1ocMedVrN/NvjR7K3Rqv5DkZ7aYHtLiUSI3hce1BCj+PVuT4bSXsblQcqeXOFOWF9UaNzRBGiaOQvceCI=
Message-ID: <c26b9592050318060863830434@mail.gmail.com>
Date: Fri, 18 Mar 2005 19:38:45 +0530
From: Imanpreet Arora <imanpreet@gmail.com>
Reply-To: Imanpreet Arora <imanpreet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on Scheduler activations
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I came across 

		http://people.redhat.com/drepper/glibcthreads.html

	It seems to arouse a bit of confusion. _FIRST_ it says that scheduler
activations are BAD. Then it delves on the possible implementation of
Scheduler activations in Linux. Though I know that scheduler
activations are not part of the present kernel. Could anyone provide
BOTH the short and long answer to

a)	If they were ever implemented?
b)	Reasons for rejection?


TIA
	
-- 

Imanpreet Singh Arora
