Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSAIQXg>; Wed, 9 Jan 2002 11:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287804AbSAIQX0>; Wed, 9 Jan 2002 11:23:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64128 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287770AbSAIQXK>; Wed, 9 Jan 2002 11:23:10 -0500
Date: Wed, 9 Jan 2002 11:25:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andre Hedrick <andre@linux-ide.org>
cc: Ricky Beam <jfbeam@bluetronic.net>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: MTBF Was: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.LNX.4.10.10201090723310.4019-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.95.1020109105301.5218A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Andre Hedrick wrote:

> 
> Ricky,

[SNIPPED...]
Don't think for an instant that MTBF has anything to do with the
actual life-time of a device. The only correlation is that a
longer MTBF may mean a longer life-time. MTBF is not equal
to life-time at all.

MTBF is a numerical value obtained by using an agreed upon
method of calculation or observation. MTBF will demonstrate
that a machine that has no components will run forever.
Of course it won't function.

Demonstrated MTBF is often (usually) obtained by taking a
large number of components and subjecting them to short-term
tests. This fails to produce any evidence of real life-time
as the following example will show:

Suppose we have a timer chip that has a defective design in
a stage which will short out and blow the device after 2 hours
of operation. We want to measure the demonstrated MTBF so we
take 10,000 chips and run them for an hour. None fail. We have
now demonstrated 10,000 hr MTBF. Simple. This is not a joke.
What is the demonstrated MTBF of a fuse? You have to destroy
it to see if it worked -- at which time it has failed.

Marketing grabbed another buzz-word and used it as a ploy to
attract customers when MTBF started appearing in consumer oriented
data sheets.

Actual observation by many, of mechanical devices such as trucks, 
tractors, steel-roll-mills and disk drives shows that once started,
then tend to run forever. However, they fail to restart if shut down
after a long period of operation. A disk-drive that sits on a shelf
often doesn't fare any better. It's like fruit that starts to decay
after being picked from the "Disk Drive Tree".

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


