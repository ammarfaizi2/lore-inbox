Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbVD2RPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbVD2RPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVD2RPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:15:09 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:19438 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262850AbVD2RPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:15:00 -0400
Date: Fri, 29 Apr 2005 10:13:35 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Daniel Phillips <phillips@istop.com>
cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
In-Reply-To: <200504282152.31137.phillips@istop.com>
Message-ID: <Pine.LNX.4.62.0504291011220.7439@qynat.qvtvafvgr.pbz>
References: <20050425151136.GA6826@redhat.com> <20050428145715.GA21645@marowsky-bree.de>
 <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz>
 <200504282152.31137.phillips@istop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005, Daniel Phillips wrote:

> On Thursday 28 April 2005 20:33, David Lang wrote:
>> how is this UUID that doesn't need to be touched by an admin, and will
>> always work in all possible networks (including insane things like backup
>> servers configured with the same name and IP address as the primary with
>> NAT between them to allow them to communicate) generated?
>>
>> there are a lot of software packages out there that could make use of
>> this.
>
> Please do not argue that the 32 bit node ID ints should be changed to uuids,
> please find another way to accommodate your uuids.

you misunderstand my question.

the claim was that UUID's are unique and don't have to be assigned by the 
admins.

I'm saying that in my experiance there isn't any standard or reliable way 
to generate such a UUID and I'm asking for the people makeing the 
claim to educate me on what I'm missing becouse a reliable UUID for linux 
on all hardware would be extremely useful for many things.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
