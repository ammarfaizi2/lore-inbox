Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLYP3F>; Mon, 25 Dec 2000 10:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130635AbQLYP2z>; Mon, 25 Dec 2000 10:28:55 -0500
Received: from itaipu.nitnet.com.br ([200.255.111.241]:40711 "HELO
	itaipu.nitnet.com.br") by vger.kernel.org with SMTP
	id <S129450AbQLYP2o>; Mon, 25 Dec 2000 10:28:44 -0500
Date: Mon, 25 Dec 2000 12:58:14 -0200
To: Igmar Palsenberg <maillist@chello.nl>
Cc: James Morris <jmorris@intercode.com.au>,
        David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: TCP keepalive seems to send to only one port
Message-ID: <20001225125814.A1154@flower.cesarb>
In-Reply-To: <20001224002020.A2497@flower.cesarb> <Pine.LNX.4.21.0012251626370.19499-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012251626370.19499-100000@server.serve.me.nl>; from maillist@chello.nl on Mon, Dec 25, 2000 at 04:27:07PM +0100
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 04:27:07PM +0100, Igmar Palsenberg wrote:
> 
> > Yeah. But I'm stuck with a NAT (which isn't mine, btw) which uses 2.1.xxx-2.2.x
> > (according to nmap). Which had a default of 15 *minutes* (as I read in a HOWTO
> > somewhere). I'm trying to convince the sysadmin to raise it to two hours, but I
> > bet it'll be hard.
> 
> ipchains -S timeoutval 0 0 is the only way to do this.
> 

That's the easy part. Convincing the sysadmin (which probably is not very
clueful) is the hard one. But this is getting too OT, EOT.

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
