Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267964AbUGaOoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267964AbUGaOoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 10:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267966AbUGaOn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 10:43:27 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:13037 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S267199AbUGaOk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 10:40:59 -0400
Message-ID: <410BAF70.7010205@backtobasicsmgmt.com>
Date: Sat, 31 Jul 2004 07:40:48 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: opendlm-devel@lists.sourceforge.net, opengfs-users@lists.sourceforge.net,
       opengfs-devel@lists.sourceforge.net, linux-cluster@redhat.com
Subject: Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
References: <410B80BC.4060100@hp.com>
In-Reply-To: <410B80BC.4060100@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K.V wrote:

> 5. Devices
>   * there is a clusterwide device model via the devfs code

Yeah, that's we want, take buggy, unreliable, 
soon-to-be-removed-from-mainline code and put an entire clustering layer 
on top of it. Too bad someone is going to need to completely reimplement 
this "clusterwide device model".
