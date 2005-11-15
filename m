Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVKOSyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVKOSyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVKOSyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:54:07 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:53894 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964979AbVKOSyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:54:05 -0500
Message-ID: <437A2ECC.1070003@watson.ibm.com>
Date: Tue, 15 Nov 2005 13:54:04 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: serue@us.ibm.com, linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap>	<20051114153649.75e265e7.pj@sgi.com>	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>	<20051114175140.06c5493a.pj@sgi.com>	<20051115022931.GB6343@sergelap.austin.ibm.com>	<20051114193715.1dd80786.pj@sgi.com>	<20051115051501.GA3252@IBM-BWN8ZTBWAO1>	<20051114223513.3145db39.pj@sgi.com>	<20051115081100.GA2488@IBM-BWN8ZTBWAO1>	<20051115010624.2ca9237d.pj@sgi.com>	<20051115133222.GA2232@IBM-BWN8ZTBWAO1>	<4379F29D.3090306@watson.ibm.com> <20051115103927.2ca4bffb.pj@sgi.com>
In-Reply-To: <20051115103927.2ca4bffb.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> I don't think that the checkpoint/restart/relocation design should be
> driven by mico-optimizations of getpid().  It needs to be driven by
> a design that addresses (for better or worse) the many larger questions
> encountered in such an effort.
> 

Neither did we suggest one.
My note, was simply addressing some of the issues that were thrown out
with the alternative articulated in the many responses.

-- Hubertus
