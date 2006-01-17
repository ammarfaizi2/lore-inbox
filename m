Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWAQSKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWAQSKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAQSKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:10:05 -0500
Received: from elvis.mu.org ([192.203.228.196]:60900 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S932142AbWAQSKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:10:03 -0500
Message-ID: <43CD32F0.9010506@FreeBSD.org>
Date: Tue, 17 Jan 2006 10:09:52 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
References: <20060117143258.150807000@sergelap>	 <43CD18FF.4070006@FreeBSD.org> <1137517698.8091.29.camel@localhost.localdomain>
In-Reply-To: <1137517698.8091.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> One use for containers might be to pick a container from a system, wrap
> it up, and transport it to another system where it would continue to
> run.  We would have to make sure that the pids did not collide with any
> containers running on the target system.

Couldn't you assign new pids when the container is transported to the 
other system?

-- Suleiman
