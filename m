Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTLBNLi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLBNLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:11:38 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:29109 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S261953AbTLBNLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:11:37 -0500
Message-ID: <3FCC8F82.5030704@backtobasicsmgmt.com>
Date: Tue, 02 Dec 2003 06:11:30 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de> <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de> <3FCC0EE0.9010207@backtobasicsmgmt.com> <20031202041513.GN1566@mis-mike-wstn.matchmail.com>
In-Reply-To: <20031202041513.GN1566@mis-mike-wstn.matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

> Can you try with DM on regular disk tm, instead of sw raid?

Tested, failure does not occur.


