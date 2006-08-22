Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWHVNtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWHVNtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWHVNtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:49:33 -0400
Received: from mxsf20.cluster1.charter.net ([209.225.28.220]:20173 "EHLO
	mxsf20.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932242AbWHVNtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:49:32 -0400
X-IronPort-AV: i="4.08,156,1154923200"; 
   d="scan'208"; a="1626368899:sNHT118974036"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17643.2921.654137.143271@stoffel.org>
Date: Tue, 22 Aug 2006 09:49:29 -0400
From: "John Stoffel" <john@stoffel.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [patch 00/20] 2.6.17-stable review
In-Reply-To: <20060821214349.GA1885@suse.de>
References: <20060821184527.GA21938@kroah.com>
	<20060821194616.GC12928@redhat.com>
	<20060821214349.GA1885@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <gregkh@suse.de> writes:

Greg> On Mon, Aug 21, 2006 at 03:46:16PM -0400, Dave Jones wrote:
>> On Mon, Aug 21, 2006 at 11:45:27AM -0700, Greg KH wrote:
>> > This is the start of the stable review cycle for the next 2.6.17.y
>> > release.  There are 20 patches in this series, all will be posted as
>> > a response to this one.  If anyone has any issues with these being
>> > applied, please let us know.  If anyone is a maintainer of the proper
>> > subsystem, and wants to add a Signed-off-by: line to the patch, please
>> > respond with it.
>> > 
>> > These patches are sent out with a number of different people on the Cc:
>> > line.  If you wish to be a reviewer, please email stable@kernel.org to
>> > add your name to the list.  If you want to be off the reviewer list,
>> > also email us.
>> 
>> Any chance of a 2.6.17.10-rc1 rollup patch again, like you did for .8?

Greg> Oops, forgot to do that, thanks for reminding me.  It can be
Greg> found at:
Greg> http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.17.10-rc1.gz

Greg> And yes, it's not in the "main" v2.6 subdirectories, I'm not going to
Greg> put it there anymore as it confuses too many scripts/people.

So what if they're confused?  If they're official releases, blessed
with holy penguin pee, then shouldn't they be in the standard release
area?  

	http://www.kernel.org/pub/linux/kernel/v2.6/

could just be extended down with a directory for each version
released, and the directory holds the ChangeLog, linux-... and
patch-... files.  

Thanks for doing the stable branch in any case!

John
