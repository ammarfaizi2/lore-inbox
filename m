Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWEDR1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWEDR1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 13:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWEDR1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 13:27:38 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:29040 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030243AbWEDR1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 13:27:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lrif0gS0o6tbpE10YhKU4lq0BxNnNOVIbUahm3ugyqTGokxzdnnHnJt3UqV7bgxVW9ct5/AWUhS7a0xshkPUEL3oJIkCgfewGcibPWlSP9yoZ1VP2XV4okw3DLNPps2x60uZQ1FczSbjdSbpM7kmJ+jVZZq1O7QupSqsbqZDxFQ=
Message-ID: <bda6d13a0605041027kc0edb02icdd11bd103478b05@mail.gmail.com>
Date: Thu, 4 May 2006 10:27:37 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cdrom: a dirty CD can freeze your system
In-Reply-To: <1146762658.22308.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605041232.k44CWnFn004411@wildsau.enemy.org>
	 <1146750532.20677.38.camel@localhost.localdomain>
	 <20060504165055.GA22880@animx.eu.org>
	 <1146762658.22308.11.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen this a few times. It never actually hung my system, only one
virtual console. I wonder if preemptable kernel had something to do
with that <g>
