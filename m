Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129176AbRBMJlF>; Tue, 13 Feb 2001 04:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBMJky>; Tue, 13 Feb 2001 04:40:54 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:56838 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S129114AbRBMJke>; Tue, 13 Feb 2001 04:40:34 -0500
Date: Tue, 13 Feb 2001 09:41:48 +0000 (GMT)
From: "Dr. David Gilbert" <gilbertd@treblig.org>
To: Tigran Aivazian <tigran@veritas.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: lost charaters -- this is becoming annoying!
In-Reply-To: <Pine.LNX.4.21.0102130915490.927-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0102130940550.1611-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Tigran Aivazian wrote:

> Hi,
>
> I amtyping this without correcting -- allthe lost characters you see
> (including spaces!) are exactly what the pseudo-tty driver does! This is
> 2.4.1 a it definitely (oh, see "nd" of the ave "and" disappeared? and
> "above" turned into "ave"!) did work fine previously -- like in the days
> of 2.3.99 and 2.4.0-teX series (yes, teX was meant to be "testX"!)
>
> So, the keyboard or pty driver is badly broken.

Hell I'm glad you said that - I thought I was going mad the other day when
I reported the missing return thing.
(On Linux/Alpha, 2.4.1-ac9, PS/2 keyboard)

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

