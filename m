Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266580AbRGLUtc>; Thu, 12 Jul 2001 16:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266573AbRGLUtW>; Thu, 12 Jul 2001 16:49:22 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:26558 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S266588AbRGLUtM>;
	Thu, 12 Jul 2001 16:49:12 -0400
Date: Thu, 12 Jul 2001 21:49:10 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Woodhouse <dwmw2@infradead.org>, torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] More pedantry.
Message-ID: <520087372.994974550@[169.254.45.213]>
In-Reply-To: <11825.994932181@redhat.com>
In-Reply-To: <11825.994932181@redhat.com>
X-Mailer: Mulberry/2.1.0b1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - *		None of the E1AP-E3AP erratas are visible to the user.
> + *		None of the E1AP-E3AP errata are visible to the user.

If you want real pedantry, I think you mean:

> + *		None of the E1AP-E3AP errata is visible to the user.

('none' is singular - read 'not one')

... several times within this patch.

--
Alex Bligh
