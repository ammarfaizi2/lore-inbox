Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWASDYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWASDYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWASDYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:24:22 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:6975 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964928AbWASDYV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:24:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qL3ksOCGxWFeHKxYqzS2L0Nn9NfUQ9VqYaKPRQo58XYSLIbRWhHJbMdYleJiTOnWRiq79xnKT2SNNwPHi5zyfYq8w3LKM6ZzvnakOyJ2crqAPHFLn9TIjR1a+HQ0jjmi3QgQ3yV+P3Iouwo6XNdZ2zmAxu2rp3ET3598oJ4CKkw=
Message-ID: <37219a840601181924gb00340fi3bbc853addefc493@mail.gmail.com>
Date: Wed, 18 Jan 2006 22:24:20 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: [2.6 patch] VIDEO_CX88_ALSA must select SND_PCM
Cc: mchehab@brturbo.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20060119012120.GW19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060119012120.GW19398@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Adrian Bunk <bunk@stusta.de> wrote:
> This patch fixes the following compile error:
> <--  snip  -->
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Adrian-

I've applied this to our cvs tree.  Mauro will apply it to v4l-dvb.git
with his first round of bugfix commits.

Thanks,

Michael
