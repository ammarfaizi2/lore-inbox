Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWJJTmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWJJTmH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWJJTmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:42:07 -0400
Received: from gw.goop.org ([64.81.55.164]:25735 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030229AbWJJTmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:42:04 -0400
Message-ID: <452BF781.4080409@goop.org>
Date: Tue, 10 Oct 2006 12:41:53 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org>	<452BE1DC.9030503@goop.org> <20061010122511.8232e9d5.akpm@osdl.org>
In-Reply-To: <20061010122511.8232e9d5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I didn't do anything to fix it.  But I haven't tested it recently - it
> might have repaired itself ;)
>   

Surely the way to check it just throw it in and see who screams...

> My plan was to pathetically spam the powerpc guys with it once all the
> above is merged up.  I took a close look and couldn't see why it was
> failing.
>   

Oh, I thought it turned out to be some other problem.  Er, something 
about numa memory stuff?

    J
