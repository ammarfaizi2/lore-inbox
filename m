Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293425AbSCEQek>; Tue, 5 Mar 2002 11:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293436AbSCEQeb>; Tue, 5 Mar 2002 11:34:31 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:13447 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S293425AbSCEQeT>; Tue, 5 Mar 2002 11:34:19 -0500
Date: Tue, 5 Mar 2002 17:34:18 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
Message-ID: <20020305173418.A13219@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020305.060323.99455532.davem@redhat.com> <20020305.060604.68157839.davem@redhat.com> <20020305153025.A12473@stud.ntnu.no> <20020305.070414.77058889.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020305.070414.77058889.davem@redhat.com>; from davem@redhat.com on Tue, Mar 05, 2002 at 07:04:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> It's not a reasonable request, it doesn't interoperate at all
> with 10/100 segments, see my other mail.

But when a load of our servers are on the same segment, they would benefit
from 1000 Gbps internally, right?

How much of an effect would changing the MTU from 1k5 til 9k do in a
scenario like that?

-- 
Thomas
