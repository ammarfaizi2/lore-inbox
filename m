Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVAUQlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVAUQlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVAUQlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:41:22 -0500
Received: from mail.joq.us ([67.65.12.105]:3786 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262424AbVAUQjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:39:33 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt 
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
	<87oefkd7ew.fsf@sulphur.joq.us>
	<10752.195.245.190.93.1106211979.squirrel@195.245.190.93>
	<65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
	<874qhb99rv.fsf@sulphur.joq.us>
	<1728.195.245.190.93.1106299090.squirrel@195.245.190.93>
	<41F12C94.4030808@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Fri, 21 Jan 2005 10:40:59 -0600
In-Reply-To: <41F12C94.4030808@kolivas.org> (Con Kolivas's message of "Sat,
 22 Jan 2005 03:23:48 +1100")
Message-ID: <87k6q620ro.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Rui Nuno Capela wrote:
>> My eyes can't find anything related, but you know how intuitive these
>> things are ;)
>
> He means when using the SCHED_ISO patch. Then you'd have iso_cpu and
> iso_period, which you have neither of so you are not using SCHED_ISO.

In that case, my suggestion was moot.  I thought Rui was running
SCHED_ISO and had just hit the 70% barrier.  Since he's not, I have no
idea what the problem is.

I'm busy building two new kernels right now.  I'll try the new
jack_test4 some time soon, when I can.
-- 
  joq
