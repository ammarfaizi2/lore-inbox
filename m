Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRB0Xei>; Tue, 27 Feb 2001 18:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129957AbRB0Xe2>; Tue, 27 Feb 2001 18:34:28 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:23729 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129953AbRB0XeR>;
	Tue, 27 Feb 2001 18:34:17 -0500
Message-ID: <XFMail.20010227153558.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010227232854.Z13721@redhat.com>
Date: Tue, 27 Feb 2001 15:35:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Tim Waugh <twaugh@redhat.com>
Subject: Re: timing out on a semaphore
Cc: linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27-Feb-2001 Tim Waugh wrote:
> On Tue, Feb 27, 2001 at 10:40:35PM +0000, Andrew Morton wrote:
> 
>> 1: Your code is leaving the semaphore in a down'ed state
>>    somehow.
> 
> This was probably it.  I don't know why it works for me but not some
> other people though. :-/

UP vs. MP ?



- Davide

