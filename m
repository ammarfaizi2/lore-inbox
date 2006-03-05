Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWCEXas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWCEXas (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEXas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:30:48 -0500
Received: from main.gmane.org ([80.91.229.2]:23974 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751307AbWCEXar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:30:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [OT] inotify hack for locate
Date: Sun, 05 Mar 2006 23:30:09 +0000
Message-ID: <yw1xu0acbhby.fsf@agrajag.inprovide.com>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> <1141594983.14714.121.camel@mindpipe> <20060305230821.GA20768@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:6jDIO5Q7/0cXnvtwK8hQVG9E7gc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Sun, Mar 05, 2006 at 04:43:03PM -0500, Lee Revell wrote:
>> updatedb runs at nice 20 on most distros, and with the CFQ scheduler the
>> IO priority follows the nice value, so why does it still kill the
>> machine?
>
> Running updatedb on a laptop when you're sitting in an airplane running 
> off of batteries is Not Nice to the user.  I know, I've had it happen far 
> too many times.

Running updatedb only if AC powered shouldn't be too difficult.

-- 
Måns Rullgård
mru@inprovide.com

