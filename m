Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbUL0UD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbUL0UD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUL0UD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:03:59 -0500
Received: from 181.Red-80-24-145.pooles.rima-tde.net ([80.24.145.181]:18573
	"EHLO minibar") by vger.kernel.org with ESMTP id S261971AbUL0UB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:01:59 -0500
From: David Martin <tasio@tasio.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] pid randomness
User-Agent: KMail/1.7.1
References: <41D064D5.1030900@rnl.ist.utl.pt>
In-Reply-To: <41D064D5.1030900@rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Disposition: inline
Date: Mon, 27 Dec 2004 21:01:54 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412272101.54370.tasio@tasio.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You have an implementation of this and other stuff on grsecurity 
(www.grsecurity.net) patch for both 2.4 and 2.6 kernel. It is intented for 
servers, critical machines, or just paranoic users :)

cheers,
david.

On Monday 27 December 2004 20:39, you wrote:
> hi everyone,
>
> I don't know if this has been discussed before... but I'd like to ask
> why isn't the pids randomized by default?
>
> I mean, of course it's not required for normal functioning but it'd be
> nice to have a Kconfig option to make it happen.
>
> The (newbie) way I see it, it'd not be hard to do... generate pid, check
> if it's unique, give pid to process. It could bring some minor security
> enhancements while taking a slight performance hit (seek & compare
> algorithm for used pids).
>
> What are the pros and cons of this? What are your oppinions on this subjet?
>
> regards,
> pedro venda.

-- 
This device complies with part 15 of the FCC rules. Operation is
subject to the following two conditions:
(1) This device may not cause harmful interference,
(2) This device must accept any interference received, including 
    interference that may cause undesired operation.
