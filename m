Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290237AbSBKTlU>; Mon, 11 Feb 2002 14:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290284AbSBKTlK>; Mon, 11 Feb 2002 14:41:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52102 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290237AbSBKTk6>;
	Mon, 11 Feb 2002 14:40:58 -0500
Subject: Re: [BUG] Panic in 2.5.4 during bootup after POSIX conformance
	testing by UNIFIX
From: Paul Larson <plars@austin.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org, Roy Sigurd Karlsbakk <roy@karlsbakk.net>
In-Reply-To: <1013454372.6781.418.camel@phantasy>
In-Reply-To: <Pine.LNX.4.30.0202111453330.28560-200000@mustard.heime.net> 
	<3C67D9CB.2030806@oracle.com>  <1013454372.6781.418.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 13:32:15 -0600
Message-Id: <1013455936.25815.41.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 13:06, Robert Love wrote:
> Can both of you try the attached patch (thanks to Mikael Pettersson),
> and tell me if it solves your problem?
> 
> 	Robert Love

I was having the same problem, but this patch seems to fix it.

Thanks!
-Paul Larson

