Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbULOFKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbULOFKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 00:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbULOFKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 00:10:17 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:44764 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261882AbULOFKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 00:10:12 -0500
Message-ID: <41BFC72D.2070800@namesys.com>
Date: Tue, 14 Dec 2004 21:10:05 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200412141930.iBEJUGdB019336@laptop11.inf.utfsm.cl>
In-Reply-To: <200412141930.iBEJUGdB019336@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk> said:
>
>[...]
>
>  
>
>>Perhaps a better way to think about this is that instead of talking
>>about directories and files, we just talk about objects.
>>    
>>
>
>Then you have a collection of interrelated objects, i.e., a database.
>Operating systems that work on databases (no filesystem) have been done,
>and are a nice idea... but are far, far away from Unix.
>  
>
A journey of a thousand leagues begins with a single step.

Actually, databases are the wrong solution because they are relational, 
and what is needed is a semi-structured query language that is upwardly 
compatible with Unix hierarchical semantics, ala 
www.namesys.com/future_vision.html
