Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSKEXac>; Tue, 5 Nov 2002 18:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSKEXac>; Tue, 5 Nov 2002 18:30:32 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:34052 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S265326AbSKEXac>;
	Tue, 5 Nov 2002 18:30:32 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200211052337.gA5Nb2j391603@saturn.cs.uml.edu>
Subject: Re: ps performance sucks
To: riel@conectiva.com.br (Rik van Riel)
Date: Tue, 5 Nov 2002 18:37:02 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, jw@pegasys.ws, wa@almesberger.net, rml@tech9.net,
       andersen@codepoet.org, woofwoof@hathway.com
In-Reply-To: <Pine.LNX.4.44L.0211052045550.3411-100000@imladris.surriel.com> from "Rik van Riel" at Nov 05, 2002 08:46:31 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> On Tue, 5 Nov 2002, Albert D. Cahalan wrote:

>> (tough luck if you're using some other ps)
>
> Why do your procps mails always contain more references to
> procps 2 than to your own version ?
>
> What is your obsession with procps 2 ?

I'm rather sick of being blamed for problems that are not
seen in procps 3. Somebody posts about procps needing to
read 5 files per process, then somebody else makes a rude
comment about me... never minding that the procps 3 code
doesn't have the behavior that was being complained about.

I also have to make the differences clear. Really, I hate
doing that. I've learned a harsh lesson though; failure to
advertise leads to forks. It also leads to people using
obsolete code. Some poor soul even started hacking on top,
not realizing that it was already rewritten and is improving
quickly.

Do realize that you _started_ with buggy old code. I really
wish you'd just let it die. There wasn't any need to start
hacking on that buggy old code; I take patches, even from you.


