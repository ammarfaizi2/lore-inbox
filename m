Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290745AbSBGSAg>; Thu, 7 Feb 2002 13:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290750AbSBGSAQ>; Thu, 7 Feb 2002 13:00:16 -0500
Received: from dsl-213-023-038-235.arcor-ip.net ([213.23.38.235]:6288 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290745AbSBGSAK>;
	Thu, 7 Feb 2002 13:00:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New locking primitive for 2.5
Date: Thu, 7 Feb 2002 19:04:58 +0100
X-Mailer: KMail [version 1.3.2]
Cc: akpm@zip.com.au, torvalds@transmet.com, mingo@elte.hu, rml@tech9.net,
        nigel@nrg.org
In-Reply-To: <3C629F91.2869CB1F@dlr.de>
In-Reply-To: <3C629F91.2869CB1F@dlr.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Ysuo-00014w-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 7, 2002 04:38 pm, Martin Wirth wrote:
> The new lock uses a combination of a spinlock and a (mutex-)semaphore.

Spinaphore :-)

-- 
Daniel
