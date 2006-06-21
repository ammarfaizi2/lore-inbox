Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWFUKWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWFUKWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWFUKWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:22:06 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:36315 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751456AbWFUKWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:22:03 -0400
Message-ID: <44991787.7010602@s5r6.in-berlin.de>
Date: Wed, 21 Jun 2006 11:55:19 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Anderson-Lee <jonah@eecs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] suggestion [PATCH N/M] subject lines
References: <000001c694bb$f9fa3f40$ce2a2080@eecs.berkeley.edu>
In-Reply-To: <000001c694bb$f9fa3f40$ce2a2080@eecs.berkeley.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Anderson-Lee wrote:
> Reading the mailing list with a non-threads compatible 
> mail client agent would be made much easier if the 
> convention for subject lines for multi-part patches was 
> changed to the following:
> 
> 	patch set name [PATCH N/M] patch summary
> 
> Then sorting by subject would group all patches for the
> Same patch set together.

A workaround is to sort by (1.) author + (2.) date. Should help in many
cases.

> I don't know if these Subject lines are hand generated, or if there
> is software involved that would have to me modified for generating
> and/or parsing them.

All of it is true.
-- 
Stefan Richter
-=====-=-==- -==- =-=-=
http://arcgraph.de/sr/
