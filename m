Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281663AbRLLRxq>; Wed, 12 Dec 2001 12:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281668AbRLLRx0>; Wed, 12 Dec 2001 12:53:26 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:22794 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S281663AbRLLRxY>; Wed, 12 Dec 2001 12:53:24 -0500
Date: Wed, 12 Dec 2001 12:53:23 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse disconnect/reconnect
Message-ID: <20011212125323.N8227@sventech.com>
In-Reply-To: <20011211222014.A13443@informatics.muni.cz> <20011211164059.C8227@sventech.com> <20011212103748.C14688@informatics.muni.cz> <20011212112548.E29229@sventech.com> <20011212172940.O14688@informatics.muni.cz> <20011212114820.F29229@sventech.com> <20011212180333.V14688@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011212180333.V14688@informatics.muni.cz>; from kas@informatics.muni.cz on Wed, Dec 12, 2001 at 06:03:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001, Jan Kasprzak <kas@informatics.muni.cz> wrote:
> [l-k removed from Cc:]
> 
> Johannes Erdfelt wrote:
> : 
> : There's your problem with disconnects. Those are illegal per the specs.
> : 
> 	What is the maximum length?

I haven't looked at the spec lately, but I think 5 meters is the
maximum. You can go longer if you use an active cable which is
essentially a one port hub. It essentially acts as a repeater.

JE

