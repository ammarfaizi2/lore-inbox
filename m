Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285552AbRLGVKD>; Fri, 7 Dec 2001 16:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285554AbRLGVJr>; Fri, 7 Dec 2001 16:09:47 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:19104 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S285552AbRLGVJ3>;
	Fri, 7 Dec 2001 16:09:29 -0500
Date: Fri, 07 Dec 2001 21:09:25 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: arjanv@redhat.com, Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <951177670.1007759364@[195.224.237.69]>
In-Reply-To: <3C0F6D99.8CF24014@redhat.com>
In-Reply-To: <3C0F6D99.8CF24014@redhat.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, 06 December, 2001 1:07 PM +0000 Arjan van de Ven 
<arjanv@redhat.com> wrote:

> Would you care to point out a statistic in the kernel that is
> incremented
> more than 10.000 times/second ? (I'm giving you a a factor of 100 of
> playroom
> here) [One that isn't per-cpu yet of course]

cat /proc/net/dev

80,000 increments a second here on at least 4 counters

--
Alex Bligh
