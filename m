Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTEJV1N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTEJV1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 17:27:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47249
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264511AbTEJV1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 17:27:13 -0400
Subject: Re: logs full of chatty IDE cdrom
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030510201744.GD662@gallifrey>
References: <20030510201744.GD662@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052599284.19351.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2003 21:41:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-10 at 21:17, Dr. David Alan Gilbert wrote:
> Hi,
>   I'm not sure but this seems to be a lot worse in 2.5.x for some
> reason; my logs are full of I/O errors, not ready's and other errors from
> my CDROM drive that is playing audio CDs; I suspect at least some of it
> is due to kscd trying to figure out if there is a CD in an empty drive.

That shouldnt be generating messages. Its more important to know why or
to see wtf its doing that generates them

