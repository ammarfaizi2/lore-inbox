Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbTCLXmI>; Wed, 12 Mar 2003 18:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbTCLXmI>; Wed, 12 Mar 2003 18:42:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8713 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261862AbTCLXmG>;
	Wed, 12 Mar 2003 18:42:06 -0500
Date: Wed, 12 Mar 2003 15:41:54 -0800
From: Greg KH <greg@kroah.com>
To: Christopher Meredith <theophile@saintmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PowerNow!, cpufreq, and swsusp
Message-ID: <20030312234154.GC27256@kroah.com>
References: <3e6fc4bc.686d.2288@saintmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6fc4bc.686d.2288@saintmail.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 06:37:32PM -0500, Christopher Meredith wrote:
> Simple question: How do I mount sysfs?

mount -t sysfs none /sys

(make sure you create /sys before you do this...)

greg k-h
