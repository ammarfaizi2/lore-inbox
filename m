Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbSLRXD1>; Wed, 18 Dec 2002 18:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbSLRXD1>; Wed, 18 Dec 2002 18:03:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40721 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267361AbSLRXD1>;
	Wed, 18 Dec 2002 18:03:27 -0500
Date: Wed, 18 Dec 2002 15:08:46 -0800
From: Greg KH <greg@kroah.com>
To: William Lee Irwin III <wli@holomorphy.com>, chris@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: converting cap_set_pg() to for_each_task_pid()
Message-ID: <20021218230845.GA1649@kroah.com>
References: <20021218055742.GE12812@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218055742.GE12812@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 09:57:42PM -0800, William Lee Irwin III wrote:
> I have a pending patch that converts cap_set_pg() to the
> for_each_task_pid() API. Could you review this, and if it
> pass, include it in your tree?

Applied to my tree, I'll send it to Linus in a bit.

thanks,

greg k-h
