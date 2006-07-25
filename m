Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWGYLGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWGYLGg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 07:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWGYLGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 07:06:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58392 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932291AbWGYLGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 07:06:35 -0400
Date: Tue, 25 Jul 2006 12:41:30 +0200
From: Jens Axboe <axboe@suse.de>
To: gmu 2k6 <gmu2006@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
Message-ID: <20060725104130.GO4044@suse.de>
References: <20060725074107.GA4044@suse.de> <f96157c40607250120s2554cbc6qbd7c42972b70f6de@mail.gmail.com> <20060725080002.GD4044@suse.de> <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com> <20060725080807.GF4044@suse.de> <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com> <20060725085700.GH4044@suse.de> <f96157c40607250309o6467bf69v8c69e9da27dc8b9c@mail.gmail.com> <20060725094604.GN4044@suse.de> <f96157c40607250319w27de6956xf20d68a415503f4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96157c40607250319w27de6956xf20d68a415503f4a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25 2006, gmu 2k6 wrote:
> >You can also use netconsole, that might be a lot easier for you. That
> >just requires networking and et netcat at the other end.
> 
> any howto?

Documentation/networking/netconsole.txt

using the modular approach is the easiest.

-- 
Jens Axboe

