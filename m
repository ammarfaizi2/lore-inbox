Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278829AbRKZLE3>; Mon, 26 Nov 2001 06:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280620AbRKZLET>; Mon, 26 Nov 2001 06:04:19 -0500
Received: from t2.redhat.com ([199.183.24.243]:47862 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S280612AbRKZLEH>; Mon, 26 Nov 2001 06:04:07 -0500
Message-ID: <3C0221A6.D5837884@redhat.com>
Date: Mon, 26 Nov 2001 11:04:06 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manik Raina <manik@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question on ioctl collisions
In-Reply-To: <3C021FAF.ABAD279E@cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manik Raina wrote:
> 
> Hi,
> 
> Is there a way in the kernel to detect ioctl conflicts
> at runtime ? This could deter people from using the
> same number while registering.

wasn't lanana tasked with providing official ioctl numbers ?
