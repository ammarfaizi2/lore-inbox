Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVAKDGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVAKDGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVAKDF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:05:27 -0500
Received: from ms-smtp-03-qfe0.socal.rr.com ([66.75.162.135]:1184 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S262412AbVAKDDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:03:24 -0500
Message-ID: <41E341FA.5040508@clones.net>
Date: Mon, 10 Jan 2005 19:03:22 -0800
From: Glendon Gross <gross@clones.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Glendon Gross <gross@clones.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDF Support interfering with IDE boot?
References: <41E337DA.7080107@clones.net>
In-Reply-To: <41E337DA.7080107@clones.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow up to my own post,  I built a kernel without UDF support to 
test my theory and found that the boot failed with the same error,
"unknown block".  So now I am in the process of building a new kernel 
after starting from my old config.gz from /proc.   At least I know that UDF
support had nothing to do with the problem.




