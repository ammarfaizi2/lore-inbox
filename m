Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271625AbRHPT2q>; Thu, 16 Aug 2001 15:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271626AbRHPT2g>; Thu, 16 Aug 2001 15:28:36 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:61401 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271625AbRHPT2a>;
	Thu, 16 Aug 2001 15:28:30 -0400
Date: Thu, 16 Aug 2001 20:28:41 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Francois Romieu <romieu@cogenit.fr>, rml@tech9.net
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] Optionally let Net Devices feed Entropy
Message-ID: <212453020.997993720@[169.254.45.213]>
In-Reply-To: <20010816190255.A17095@se1.cogenit.fr>
In-Reply-To: <20010816190255.A17095@se1.cogenit.fr>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What is experimental about it?
>
> The implicit-and-should-be-debated-in-2.5 assumption that the entropy
> estimate still makes sense ?

As opposed to the huge amount of sense it currently makes to
collect it depending on your NIC manufacturer, as opposed to
dependent upon a config option?

If you mean that the option should be labelled 'not for
the paranoid' I agree. The patch does that. 'Experimental'
means the code may crash, or perform other than as advertized.

--
Alex Bligh
