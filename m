Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUH0Unj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUH0Unj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUH0Uk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:40:59 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:26568 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S267405AbUH0UiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:38:13 -0400
From: David Brownell <david-b@pacbell.net>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Summarizing the PWC driver questions/answers
Date: Fri, 27 Aug 2004 13:14:27 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
In-Reply-To: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408271314.27350.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 12:54 pm, Kenneth Lavrsen wrote:

> You did not HAVE TO remove the hook. It had been there for years. You could 
> have worked out an alternative way nice and quietly....

And it had also been an issue for years, on technical grounds too:
that such number crunching does not belong in-kernel.

That's evidence that there was really no "alternative" way.

- Dave

