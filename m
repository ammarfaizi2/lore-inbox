Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbTAMQjX>; Mon, 13 Jan 2003 11:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267882AbTAMQjW>; Mon, 13 Jan 2003 11:39:22 -0500
Received: from [195.20.32.236] ([195.20.32.236]:33973 "HELO euro.verza.com")
	by vger.kernel.org with SMTP id <S267879AbTAMQjV>;
	Mon, 13 Jan 2003 11:39:21 -0500
Date: Mon, 13 Jan 2003 17:10:45 +0100
From: Alexander Kellett <lypanov@kde.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Rob Wilkens <robw@optonline.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*? -> goto example
Message-ID: <20030113161045.GA19270@groucho.verza.com>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Rob Wilkens <robw@optonline.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121208020.14031-100000@home.transmeta.com> <1042404503.1208.95.camel@RobsPC.RobertWilkens.com> <20030112224829.GA29534@alpha.home.local> <1042419236.3162.257.camel@RobsPC.RobertWilkens.com> <20030113013133.GA31596@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113013133.GA31596@alpha.home.local>
User-Agent: Mutt/1.4i
X-Disclaimer: My opinions do not necessarily represent those of my employer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 02:31:33AM +0100, Willy Tarreau wrote:
> Oh and if you have complaints about comments after the 80th column, remove them.
> And if the order of the declaration doesn't match your habits, just know that
> this is the order which gives me best performance, since swapping any 2 of its
> members induces a loss of about 20%. You know, L1, cache line size... all the
> things that your teachers didn't tell you because the story of the evil goto was
> better to keep children quiet !

:)

As much as I absolutely love the utility of this 
piece of code you really do have to admit that it 
_is_ rather difficult to understand :)

Is it so flawed of me to expect that some day this
code could be rewritten in an extremely clean
fashion and compilers made to do the work that
was put in to make this fast?

mvg,
Alex

-- 
"[...] Konqueror open source project. Weighing in at less than
            one tenth the size of another open source renderer"
Apple,  Jan 2003 (http://www.apple.com/safari/)
