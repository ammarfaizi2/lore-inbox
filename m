Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbRFAVe4>; Fri, 1 Jun 2001 17:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbRFAVeq>; Fri, 1 Jun 2001 17:34:46 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:56595 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S261617AbRFAVef>; Fri, 1 Jun 2001 17:34:35 -0400
Subject: Re: New USB HID driver in -ac series
From: Robert "M." Love <rml@tech9.net>
To: Nathan Walp <faceprint@faceprint.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010601143544.A2091@patience.faceprint.com>
In-Reply-To: <20010601143544.A2091@patience.faceprint.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 01 Jun 2001 17:34:39 -0400
Message-Id: <991431280.653.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Jun 2001 14:35:44 -0400, Nathan Walp wrote:
> I upgraded from 2.4.5-ac2 to 2.4.5-ac5 recently, and all seemed well.
> However, I noticed that the scrollwheel on my mouse wasn't working very
> well.  <snip>

I have been working on a patch all day, but can not figure it out.  The
problem is in the new hid-core.c.  See the thread "USB mouse wheel
breakage" for more information.

I CC the last e-mail to the Maintainer, hopefully he can figure a
solution.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

