Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTLQQIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTLQQIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:08:23 -0500
Received: from needs-no.brain.uni-freiburg.de ([132.230.63.23]:5401 "EHLO
	needs-no.brain.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264453AbTLQQIV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:08:21 -0500
Date: Wed, 17 Dec 2003 17:08:17 +0100 (MET)
From: Thomas Voegtle <thomas@voegtle-clan.de>
To: linux-kernel@vger.kernel.org
cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
In-Reply-To: <yw1xd6anjwt6.fsf@kth.se>
Message-ID: <Pine.LNX.4.21.0312171704030.32339-100000@needs-no.brain.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, Måns Rullgård wrote:

> The following message is a courtesy copy of an article
> that has been posted to gmane.linux.kernel as well.
> 
> Thomas Voegtle <thomas@voegtle-clan.de> writes:
> 
> > cdrecord -dev=ATAPI -scanbus  with 2.6.0-test11-bk10 and bk13 shows this:
> 
> cdrecord dev=/dev/cdrom -scanbus  is the recommended way, whatever
> cdrecord tries to make you believe.

Well, this doesn't change the fact that I cannot burn cdroms.
But I can burn with vanilla 2.6.0-test11

Greetings


-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------


