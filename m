Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281005AbRLLQso>; Wed, 12 Dec 2001 11:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281116AbRLLQse>; Wed, 12 Dec 2001 11:48:34 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:13319 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S281005AbRLLQsU>; Wed, 12 Dec 2001 11:48:20 -0500
Date: Wed, 12 Dec 2001 11:48:20 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse disconnect/reconnect
Message-ID: <20011212114820.F29229@sventech.com>
In-Reply-To: <20011211222014.A13443@informatics.muni.cz> <20011211164059.C8227@sventech.com> <20011212103748.C14688@informatics.muni.cz> <20011212112548.E29229@sventech.com> <20011212172940.O14688@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011212172940.O14688@informatics.muni.cz>; from kas@informatics.muni.cz on Wed, Dec 12, 2001 at 05:29:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001, Jan Kasprzak <kas@informatics.muni.cz> wrote:
> Johannes Erdfelt wrote:
> : On Wed, Dec 12, 2001, Jan Kasprzak <kas@informatics.muni.cz> wrote:
> : > Johannes Erdfelt wrote:
> : > : It may be because of a flaky cable. Are there any messages above that?
> : > : 
> : > 	No messages from USB (some HW csum failures from the eth0, but
> : > nothing related to my mouse). But you may be right, the mouse is connected
> : > via a 5m extension USB cable.
> : 
> : Is it an active extension cable?
> 
> 	No. Just a simple passive one.

There's your problem with disconnects. Those are illegal per the specs.

JE

