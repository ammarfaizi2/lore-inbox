Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUKSTiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUKSTiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 14:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKSTiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 14:38:22 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:46922 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261552AbUKSTiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 14:38:14 -0500
Message-ID: <419E4BA1.8030608@google.com>
Date: Fri, 19 Nov 2004 11:38:09 -0800
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040324
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Nelson <james4765@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE ioctl documentation & a new ioctl
References: <419D5CE6.8030503@google.com> <419D6CC3.4030308@verizon.net>
In-Reply-To: <419D6CC3.4030308@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd probably make a subdirectory - i. e. Documentation/ioctl/hdio.txt - 
> to differentiate it from other documents, and make it easier to get 
> maintainers to put some stuff in there. ;)   AFAICT, there is next to no 
> documentation on ioctl's anywhere in the kernel tarball.

Good point; the existance of an ioctl subdirectory would encourage 
others to write documentation as well.
